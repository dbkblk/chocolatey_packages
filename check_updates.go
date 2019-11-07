package main

import (
	"bytes"
	"compress/gzip"
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
)

// GetLocalVersion - Check local version string
func GetLocalVersion(name string) string {
	scriptPath, err := os.Executable()
	CheckError(err)

	// DEBUG Path hardcode
	scriptPath = "/home/hadrien/Dev/chocolatey/"

	versionPath := filepath.Join(scriptPath, "src", name, "latest.ps1")
	dat, err := ioutil.ReadFile(versionPath)

	// Return a null version if impossible
	if err != nil {
		return "0.0.0"
	}

	// Extract the version
	version := GetFirstMatch(string(dat), `\$version = '([\w\.\-]*)'`)

	return version
}

// GetDistantVersion - Check distant version string, based on a http page and a regex
func GetDistantVersion(url, regExpression string) string {
	page := GetPage(url)
	version := GetFirstMatch(page, regExpression)
	return version
}

// GetFirstMatch - Return the content of the first matched RegexGroup
func GetFirstMatch(content, regexExpression string) string {

	regex := *regexp.MustCompile(regexExpression)
	res := regex.FindAllStringSubmatch(string(content), -1)
	return res[0][1]
}

// GetPage - Return the content of a webpage into a string
func GetPage(url string) string {

	client := new(http.Client)

	request, err := http.NewRequest("GET", url, nil)
	CheckError(err)
	request.Header.Add("Accept-Encoding", "gzip")

	response, err := client.Do(request)

	// do this now so it won't be forgotten
	defer response.Body.Close()

	// Check that the server actually sent compressed data
	var reader io.ReadCloser
	switch response.Header.Get("Content-Encoding") {
	case "gzip":
		reader, err = gzip.NewReader(response.Body)
		defer reader.Close()
	default:
		reader = response.Body
	}

	// Conversion to string
	buf := new(bytes.Buffer)
	buf.ReadFrom(reader)
	html := buf.String()

	return html
}

// CheckError - Get error message back
func CheckError(e error) {
	if e != nil {
		panic(e)
	}
}

// Log - Shortcut for printing a value on the screen
func Log(message string) {
	fmt.Print(string(message))
}

// LaunchCommand - Launch a command
func LaunchCommand(command *exec.Cmd) {
	err := command.Start()
	CheckError(err)
	err = command.Wait()
	CheckError(err)
}

// PushUpdate - Create a update file and push the update
func PushUpdate(name, version, url string) {
	Log(name + " -> " + version)

	// Preparing the package file
	scriptPath, err := os.Executable()
	CheckError(err)

	// DEBUG Path hardcode
	scriptPath = "/home/hadrien/Dev/chocolatey/"

	versionPath := filepath.Join(scriptPath, "src", name, "latest.ps1")

	d1 := []byte("$version = '" + version + "'\n$url = '" + url + "'")
	err = ioutil.WriteFile(versionPath, d1, 0644)
	CheckError(err)

	// Push the update to git
	commitMessage := `"` + name + "|" + version + `"`
	LaunchCommand(exec.Command("git", "add", versionPath))
	LaunchCommand(exec.Command("git", "commit", `-m`, commitMessage))
	LaunchCommand(exec.Command("git", "push"))
}

// Main function
func main() {
	fmt.Println("Chocolatey package check")

	// Launch git pull command
	LaunchCommand(exec.Command("git", "pull"))

	// Homebank package
	homebankLocal := GetLocalVersion("homebank")
	homebankDistant := GetDistantVersion("http://homebank.free.fr/downloads.php", `/public/HomeBank-([\w\.\-]*)-setup.exe">&gt; HomeBank-`)

	if homebankDistant > homebankLocal {
		url := "http://homebank.free.fr/public/HomeBank-" + homebankDistant + "-setup.exe"
		PushUpdate("homebank", homebankDistant, url)
	}

	// Darktable package
	darktableLocal := GetLocalVersion("darktable")
	darktableDistant := GetDistantVersion("https://github.com/darktable-org/darktable/releases/latest", `release-[\w\.\-]*\/darktable-([\w\.\-]*)-win64.exe`)

	if darktableDistant > darktableLocal {
		url := "https://github.com/darktable-org/darktable/releases/download/release-" + darktableDistant + "/darktable-" + darktableDistant + "-win64.exe"
		PushUpdate("darktable", darktableDistant, url)
	}
}

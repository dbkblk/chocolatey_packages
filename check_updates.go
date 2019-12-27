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
	"strings"
)

// GetLocalVersion - Check local version string
func GetLocalVersion(name string) string {
	scriptPath, err := os.Executable()
	CheckError(err)

	// DEBUG Path hardcode
	// scriptPath = "/mnt/disk/projects/chocolatey_packages/"

	versionPath := filepath.Join(filepath.Dir(scriptPath), "src", name, "latest.ps1")
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
	// scriptPath = "/mnt/disk/projects/chocolatey_packages/"

	versionPath := filepath.Join(filepath.Dir(scriptPath), "src", name, "latest.ps1")

	d1 := []byte("$version = '" + version + "'\n$url = '" + url + "'")
	err = ioutil.WriteFile(versionPath, d1, 0644)
	CheckError(err)

	// Push the update to git
	commitMessage := `"` + name + "|" + version + `"`
	LaunchCommand(exec.Command("git", "add", versionPath))
	LaunchCommand(exec.Command("git", "commit", `-m`, commitMessage))
	LaunchCommand(exec.Command("git", "push"))
}

// PackageRoutine - Standard routine for checking and updating packages
func PackageRoutine(name, webpage, regex, preparedUrl string) {
	Log("Checking -> " + name + "\n")
	local := GetLocalVersion(name)
	distant := GetDistantVersion(webpage, regex)

	if distant > local {
		url := strings.Replace(preparedUrl, "{{version}}", distant, -1)
		PushUpdate(name, distant, url)
	}
}

// Main function
func main() {
	Log("Chocolatey package check\n")

	// Change software location
	err := os.Chdir("/home/hadrien/conf/chocolatey_packages/")
	CheckError(err)

	// Launch git pull command
	LaunchCommand(exec.Command("git", "pull"))

	// Routines
	PackageRoutine(
		"homebank",
		"http://homebank.free.fr/downloads.php",
		`/public/HomeBank-([\w\.\-]*)-setup.exe">&gt; HomeBank-`,
		"http://homebank.free.fr/public/HomeBank-{{version}}-setup.exe",
	)

	PackageRoutine(
		"darktable",
		"https://github.com/darktable-org/darktable/releases/latest",
		`release-[\w\.\-]*\/darktable-([\w\.\-]*)-win64.exe`,
		"https://github.com/darktable-org/darktable/releases/download/release-{{version}}/darktable-{{version}}-win64.exe",
	)

	PackageRoutine(
		"microsoft-r-open",
		"https://github.com/Microsoft/microsoft-r-open/releases/latest",
		`https://github.com/Microsoft/microsoft-r-open/commits/MRO-([\w\.\-]*).atom`,
		"https: //mran.blob.core.windows.net/install/mro/{{version}}/windows/microsoft-r-open-{{version}}.exe",
	)

	PackageRoutine(
		"rawtherapee",
		"http://rawtherapee.com/downloads",
		`\/builds\/windows\/RawTherapee_([\w\.]*)_WinVista_64.zip`,
		"https://rawtherapee.com/shared/builds/windows/RawTherapee_{{version}}_WinVista_64.zip",
	)

	PackageRoutine(
		"terminus",
		"https://github.com/Eugeny/terminus/releases/latest",
		`terminus\/releases\/download\/v[\w\.\-]*\/terminus-([\w\.\-]*)-setup.exe`,
		"https://github.com/Eugeny/terminus/releases/download/v{{version}}/terminus-{{version}}-setup.exe",
	)

	// Manual routine for xmind, because of the weird version numdering
	name := "xmind"
	Log("Checking -> " + name + "\n")
	local := GetLocalVersion(name)
	page := GetPage("https://www.xmind.net/download/xmind8")
	version1 := GetFirstMatch(page, `/xmind\/downloads\/xmind-(\d*)-update[\d*]-windows.exe`)
	version2 := GetFirstMatch(page, `/xmind\/downloads\/xmind-[\d*]-update(\d*)-windows.exe`)
	distant := version1 + "." + version2

	if distant > local {
		url := "https://www.xmind.net/xmind/downloads/xmind-" + version1 + "-update" + version2 + "-windows.exe"
		PushUpdate(name, distant, url)
	}

	Log("Chocolatey package check ended\n")
}

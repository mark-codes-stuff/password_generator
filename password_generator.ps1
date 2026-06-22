# For FAQ/help or to get the latest version of this script please check https://github.com/mark-codes-stuff/password_generator
# Licensed under the MIT Licence - see the LICENCE file in the repo for details

# Ensure wordlist.txt is in the same directory as the script
$ErrorActionPreference = "Continue"

try {

# Basic log function for writing anything to the console
function Write-Log {
		param($logContent)
		$timestamp = Get-Date -Format HH:mm
		Write-Host "[$timestamp]: $logContent"
	}

# Set location we're running the script from, grab the word list
$workingDir = Get-Location
$passwordList = "$workingDir\wordlist.txt"

# Divide the word list into 4 and 5 letter words
$4lengthWords = Get-Content -Path $passwordList | Where-Object {$_.length -eq 4}
$5lengthWords = Get-Content -Path $passwordList | Where-Object {$_.length -eq 5}

# If we're making a 13 char initial password we can either do 2x4 + 1x5 letter words, or 1x4 + 2x5 letter words
# Let's keep it random
$passwordMode = Get-Random -Minimum 0 -Maximum 2

if ($passwordMode) {
    $firstWord  = $4lengthWords | Get-Random
    $secondWord = $4lengthWords | Get-Random
    $thirdWord  = $5lengthWords | Get-Random
} else {
    $firstWord  = $4lengthWords | Get-Random
    $secondWord = $5lengthWords | Get-Random
    $thirdWord  = $5lengthWords | Get-Random
}

# Random number for the end of the password
$passwordNumber = Get-Random -Minimum 1 -Maximum 10

Write-Log "Password words are: $firstWord $secondWord $thirdWord"
# Merge the 3 words & number into one string
$mergePassword = $firstWord + $secondWord + $thirdWord + $passwordNumber
# Capitalise the first letter
$mergePassword = $mergePassword.Substring(0,1).ToUpper() + $mergePassword.Substring(1)
# Provide the full password
Write-Log "Password is: $mergePassword"
Read-Host "Copy the password and/or hit enter to close"
    
}

catch {
    Write-Log "Error: $($_.Exception.Message)"
	Write-Log "Line $($_.InvocationInfo.ScriptLineNumber)"
	Read-Host "Press enter to exit"
}

finally {

}

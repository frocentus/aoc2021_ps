$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$horizontal = 0
$vertical = 0
$data.ForEach({
    $parts = $_ -split ' '
    switch ($parts[0].Length) {
        7 { $horizontal += [int]$parts[1] }
        4 { $vertical += [int]$parts[1] }
        2 { $vertical -= [int]$parts[1] }
    }
})
$horizontal * $vertical

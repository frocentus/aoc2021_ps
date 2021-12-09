$data = Get-Content -Path "$($PSScriptRoot)/input.txt"

$xdim = $data[0].Length
$ydim = $data.Count
$basin = New-Object int[][] $xdim, $ydim
$lowpoints = New-Object int[][] $xdim, $ydim

for($y=0; $y -lt $ydim; $y++) {
    for($x=0; $x -lt $xdim; $x++) {
        $line = "$($data[$y])"
        #Write-Host "$($line[$x]) " -NoNewline
        $basin[$x][$y] = [int]($line[$x].ToString())
    }
    #Write-Host "`n" -NoNewline
}

$sum = 0
$xdim -= 1
$ydim -= 1

for($y=0; $y -le $ydim; $y++) {
    for($x=0; $x -le $xdim; $x++) {
        $val = $basin[$x][$y]
        
        $all_higher = $true
        if ($y -gt 0) { if ($basin[$x][$y-1] -le $val) { $all_higher = $false } }                           # [ 0,-1]
        if ($x -gt 0) { if ($basin[$x-1][$y] -le $val) { $all_higher = $false } }                           # [-1, 0]
        if ($x -lt $xdim) { if ($basin[$x+1][$y] -le $val) { $all_higher = $false } }                       # [ 1, 0]
        if ($y -lt $ydim) { if ($basin[$x][$y+1] -le $val) { $all_higher = $false } }                       # [ 0, 1]
        
        if ($all_higher -eq $true) {
            Write-Host "$val " -NoNewline -ForegroundColor Yellow
            $sum = $sum + ($val + 1)
        } else {
            Write-Host "$val " -NoNewline
        }
        
    }
    Write-Host "`n" -NoNewline
}

$sum






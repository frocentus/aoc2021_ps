$data = Get-Content -Path "$($PSScriptRoot)/input.txt"


$global:xdim = $data[0].ToCharArray().Length
$global:ydim = $data.Length
$global:octopuses = New-Object Octopus[][] $xdim, $ydim
$global:flashes = 0


class Octopus {
    [int]$x
    [int]$y
    [int]$level
    [bool]$has_flashed

    Octopus($x, $y, $level) {
        $this.x = $x
        $this.y = $y
        $this.level = $level
    }

    IncreaseLevel() {
        if ($this.has_flashed -eq $false) {
            $this.level = $this.level + 1
            if ($this.level -gt 9) {
                $global:flashes += 1
                $this.has_flashed = $true
                $this.level = 0
                $x1 = -1
                $y1 = -1
                $y1 = $this.y-1; 
                if ($y1 -ge 0) {
                    $x1 = $this.x-1; 
                    if ($x1 -ge 0) { 
                        $global:octopuses[$y1][$x1].IncreaseLevel()
                    }
                    $x1 = $this.x;   
                    $global:octopuses[$y1][$x1].IncreaseLevel()
                    $x1 = $this.x+1; 
                    if ($x1 -lt $global:xdim) { 
                        $global:octopuses[$y1][$x1].IncreaseLevel()
                    }
                }

                $y1 = $this.y; 
                $x1 = $this.x-1; 
                if ($x1 -ge 0) { 
                    $global:octopuses[$y1][$x1].IncreaseLevel()
                }
                $x1 = $this.x+1; 
                if ($x1 -lt $global:xdim) { 
                    $global:octopuses[$y1][$x1].IncreaseLevel()
                }
                
                $y1 = $this.y+1; 
                if ($y1 -lt $global:ydim) {
                    $x1 = $this.x-1; 
                    if ($x1 -ge 0) { 
                        $global:octopuses[$y1][$x1].IncreaseLevel()
                    }                    
                    $x1 = $this.x;   
                    $global:octopuses[$y1][$x1].IncreaseLevel()

                    $x1 = $this.x+1; 
                    if ($x1 -lt $global:xdim) { 
                        $global:octopuses[$y1][$x1].IncreaseLevel()
                    }  
                }
            }
        }
    }
}


$y = 0
foreach($line in $data) {
    $chars = $line.ToCharArray()
    for($x=0; $x -lt $xdim; $x++) {
        $global:octopuses[$y][$x] = [Octopus]::new($x, $y, [int]"$($chars[$x])")
    }
    $y++
}



for($r=1; $r -le 100; $r++) {
    Write-Host "Round $r"
    for($y=0; $y -lt $ydim; $y++) {
        for($x=0; $x -lt $xdim; $x++) {
            $octopuses[$y][$x].has_flashed = $false
        }
    }
    for($y=0; $y -lt $ydim; $y++) {
        for($x=0; $x -lt $xdim; $x++) {
            $op = $octopuses[$y][$x]
            $op.IncreaseLevel()
            if ($op.level -eq 0) {
                Write-Host "$($op.level)" -NoNewline -ForegroundColor Yellow
            } else {
                Write-Host "$($op.level)" -NoNewline -ForegroundColor Gray
            }
        }
        Write-Host " "
    }
    Write-Host "Finished Round $r total $flashes"
}
Write-Host "`n"
$global:flashes
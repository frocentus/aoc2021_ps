$data = Get-Content -Path "$($PSScriptRoot)/input.txt"

$xdim = $data[0].Length
$ydim = $data.Count
$basin = New-Object int[][] $xdim, $ydim

for($y=0; $y -lt $ydim; $y++) {
    for($x=0; $x -lt $xdim; $x++) {
        $line = "$($data[$y])"
        $basin[$x][$y] = [int]($line[$x].ToString())
    }
}

$xdim -= 1
$ydim -= 1

function FloodFill($x, $y, $val) {
    [System.Collections.Queue]$queue = @()   
    $local = @()
    $p = [System.Tuple]::Create($x,$y)
    $local += $p
    $queue.Enqueue($p)

    while ($queue.Length -gt 0) {
        $current = $queue.Dequeue()
        
        
        $x1 = $current.Item1
        $y1 = $current.Item2
        $val = $basin[$x1][$y1]
        if ($val -ge 0) {
            if ($y1 -gt 0) { if ($basin[$x1][$y1-1] -lt 9 -and $basin[$x1][$y1-1] -gt 0) {
                $next = [System.Tuple]::Create($x1,$y1-1)
                $local += $next
                $queue.Enqueue($next)
            } }                           # [ 0,-1]
            if ($x1 -gt 0) { if ($basin[$x1-1][$y1] -lt 9 -and $basin[$x1-1][$y1] -ge 0) { 
                $next = [System.Tuple]::Create($x1-1,$y1)
                $local += $next
                $queue.Enqueue($next)
            } }                           # [-1, 0]
            if ($x1 -lt $xdim) { if ($basin[$x1+1][$y1] -lt 9 -and $basin[$x1+1][$y1] -gt 0) { 
                $next = [System.Tuple]::Create($x1+1,$y1)
                $local += $next
                $queue.Enqueue($next)
            } }                       # [ 1, 0]
            if ($y1 -lt $ydim) { if ($basin[$x1][$y1+1] -lt 9 -and $basin[$x1][$y1+1] -gt 0) { 
                $next = [System.Tuple]::Create($x1,$y1+1)            
                $local += $next
                $queue.Enqueue($next)
            } }                       # [ 0, 1]
            $basin[$x1][$y1] = $basin[$x1][$y1] * -1
        }
    }
    $local = $local | Select-Object -Unique
    $local.Count
}

$basins = @()

for($y=0; $y -le $ydim; $y++) {
    for($x=0; $x -le $xdim; $x++) {
        $val = $basin[$x][$y]
        $all_higher = $true
        if ($x -gt 0 -and $y -gt 0) { if ($basin[$x-1][$y-1] -le $val) { $all_higher = $false } }           # [-1,-1]
        if ($y -gt 0) { if ($basin[$x][$y-1] -le $val) { $all_higher = $false } }                           # [ 0,-1]
        if ($x -lt $xdim -and $y -gt 0) { if ($basin[$x+1][$y-1] -le $val) { $all_higher = $false } }       # [ 1,-1]
        
        if ($x -gt 0) { if ($basin[$x-1][$y] -le $val) { $all_higher = $false } }                           # [-1, 0]
        if ($x -lt $xdim) { if ($basin[$x+1][$y] -le $val) { $all_higher = $false } }                  # [ 1, 0]
        
        if ($x -gt 0 -and $y -lt $ydim) { if ($basin[$x-1][$y+1] -le $val) { $all_higher = $false } }       # [-1, 1]
        if ($y -lt $ydim) { if ($basin[$x][$y+1] -le $val) { $all_higher = $false } }                       # [ 0, 1]
        if ($x -lt $xdim -and $y -lt $ydim) { if ($basin[$x+1][$y+1] -le $val) { $all_higher = $false } }   # [ 1, 1]
        
        if ($all_higher -eq $true) {
            $basins += (FloodFill $x $y)
        } else {
        }
        
    }
}

$first3 = $basins | Sort-Object -Descending | Select-Object -First 3
$first3[0] * $first3[1] * $first3[2]






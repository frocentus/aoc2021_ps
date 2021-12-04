$data = Get-Content -Path "$($PSScriptRoot)/input.txt"

$numbers = $data[0] -split ','
$data = $data | Select-Object -Skip 2

$rowlength = 0
$players= [ordered]@{  }
$board = [ordered]@{ }
$player_number = 0
$row_number = 0
foreach($line in $data) {
    $line = $line.Trim().Replace('  ', ' ')

    if($line.Length -gt 0) {
        $row = $line.Split(' ') | ForEach-Object { [int]$_ }
        $rowlength = $row.Length
        $board.Add("$row_number", $row)
        $row_number++
    } else {    
        $players.Add($player_number, $board)
        $player_number++
        $row_number = 0
        $board = [ordered]@{ }
    }
}
$players.Add($player_number, $board)
$player_number++

$row_count = $row_number
$player_count = $player_number

:ergebnis foreach($number in $numbers) {
    for($i=0;$i -lt $player_count; $i++) {
        for($j=0;$j -lt $row_count; $j++) {
            for($k=0;$k -lt $rowlength; $k++) {
                if ($players[$i][$j][$k] -eq $number) {
                    $players[$i][$j][$k] = -1
                }
            }
        }
        
        
        for($j=0;$j -lt $row_count; $j++) {
            $row_win = $true
            for($k=0;$k -lt $rowlength; $k++) {
                if ($players[$i][$j][$k] -gt -1) {
                    $row_win = $false
                }
            }
            if ($row_win -eq $true) {
                ($players[$i].Values | Foreach-Object { $_ | Foreach-Object { $_ } } | Where-Object { $_ -gt -1 } | Measure-Object -Sum).Sum * $number
                exit
            }
        }
        for($k=0;$k -lt $rowlength; $k++) {
            $col_win = $true
            for($j=0;$j -lt $row_count; $j++) {
                if ($players[$i][$j][$k] -gt -1) {
                    $col_win = $false
                }
            }
            if ($col_win -eq $true) {
                ($players[$i].Values | Foreach-Object { $_ | Foreach-Object { $_ } } | Where-Object { $_ -gt -1 } | Measure-Object -Sum).Sum * $number
                exit
            }            
        }

    }
}



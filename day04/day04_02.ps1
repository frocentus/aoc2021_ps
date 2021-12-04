$data = Get-Content -Path "$($PSScriptRoot)/input.txt"

$numbers = $data[0] -split ','
$data = $data | Select-Object -Skip 2

$rowlength = 0
$players = [ordered]@{  }
$board = [ordered]@{ }
$player_number = 0
$row_number = 0
foreach ($line in $data) {
    $line = $line.Trim().Replace('  ', ' ')

    if ($line.Length -gt 0) {
        $row = $line.Split(' ') | ForEach-Object { [int]$_ }
        $rowlength = $row.Length
        $board.Add("$row_number", $row)
        $row_number++
    }
    else {    
        $board['id'] = $player_number
        $players.Add($player_number, $board)
        $player_number++
        $row_number = 0
        $board = [ordered]@{ }
    }
}
$board['id'] = $player_number
$players.Add($player_number, $board)
$player_number++

$row_count = $row_number

:ergebnis foreach ($number in $numbers) {
    for ($i = 0; $i -lt $players.Count; $i++) {
        $player = $players.Item($i)
        for ($j = 0; $j -lt $row_count; $j++) {
            for ($k = 0; $k -lt $rowlength; $k++) {
                if ($player[$j][$k] -eq $number) {
                    $player[$j][$k] = -1
                }
            }
        }
    }
    $players_to_delete = @()
    for ($i = 0; $i -lt $players.Count; $i++) {    
        $player = $players.Item($i)
        for ($j = 0; $j -lt $row_count; $j++) {
            $row_win = $true
            for ($k = 0; $k -lt $rowlength; $k++) {
                if ($player[$j][$k] -gt -1) {
                    $row_win = $false
                }
            }
            if ($row_win -eq $true) {
                if ($players.Count -eq 1) {
                    (($player.Values | Foreach-Object { $_ | Foreach-Object { $_ } } | Where-Object { $_ -gt -1 } | Measure-Object -Sum).Sum - $player.id) * $number
                    exit
                }
                $players_to_delete += $player.id


            }
        }
        for ($k = 0; $k -lt $rowlength; $k++) {
            $col_win = $true
            for ($j = 0; $j -lt $row_count; $j++) {
                if ($player[$j][$k] -gt -1) {
                    $col_win = $false
                }
            }
            if ($col_win -eq $true) {
                if ($players.Count -eq 1) {
                    (($player.Values | Foreach-Object { $_ | Foreach-Object { $_ } } | Where-Object { $_ -gt -1 } | Measure-Object -Sum).Sum - $player.id) * $number
                    exit
                }
                $players_to_delete += $player.id
            }         
          
        }

    }

    foreach($p in $players_to_delete) {
        $players.Remove($p)
    }

}




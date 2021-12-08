$data = Get-Content -Path "$($PSScriptRoot)/input.txt"
$sum = 0

$data.ForEach({
    $line = $_.Split('|')
    $segments = $line[0].Trim().Split(' ')
    $numbers = $line[1].Trim().Split(' ')
    $map = @{}
    $map['1'] = (($segments | Where-Object { $_.Trim().Length -eq 2}).Trim().ToCharArray() | Sort-Object) -join ''
    $map['7'] = (($segments | Where-Object { $_.Trim().Length -eq 3}).Trim().ToCharArray() | Sort-Object) -join ''
    $map['4'] = (($segments | Where-Object { $_.Trim().Length -eq 4}).Trim().ToCharArray() | Sort-Object) -join ''
    $map['8'] = (($segments | Where-Object { $_.Trim().Length -eq 7}).Trim().ToCharArray() | Sort-Object) -join ''
    
    $segments | Sort-Object -Property Length -Descending | ForEach-Object {
        $segment = ($_.Trim().ToCharArray() | Sort-Object) -join ''
        switch ( $segment.Length ) {
            5 {
                $result = $map['7'].ToCharArray() | ForEach-Object { $_ -in $segment.ToCharArray()} | Where-Object { $_ -eq $false }
                if ($null -eq $result) {
                    $map['3'] = $segment
                } else {
                    $result = $map['6'].ToCharArray() | ForEach-Object { $_ -in $segment.ToCharArray()} | Where-Object { $_ -eq $true }
                    if ($result.Count -eq 5) {
                        $map['5'] = $segment
                    } else {
                        $map['2'] = $segment
                    }
                }
            }
            6 {
                $result = $map['1'].ToCharArray() | ForEach-Object { $_ -in $segment.ToCharArray()} | Where-Object { $_ -eq $false }
                if ($null -eq $result) {
                    $result = $map['4'].ToCharArray() | ForEach-Object { $_ -in $segment.ToCharArray()} | Where-Object { $_ -eq $false }
                    if ($null -eq $result) { 
                        $map['9'] = $segment
                    } else {
                        $map['0'] = $segment
                    }
                } else {
                    $map['6'] = $segment
                }
            }
            Default {

            }
        }
    }
    
    $result = ""
    $numbers.ForEach({
        $number = [string]::new(($_.ToCharArray() | Sort-Object))
        foreach($k in ($map.GetEnumerator() | Where-Object { $_.Value -eq $number } )) {
            $result = "$result$($k.name)"
            # Write-Host "$number = $($k.name)"
        }
       
    })

    $sum += ([int]$result)

})

$sum


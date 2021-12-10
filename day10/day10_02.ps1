$data = Get-Content -Path "$($PSScriptRoot)/input.txt"

$results = @()

foreach ($line in $data) {

    $stack = [System.Collections.Stack]::new()
    Write-Host "`n> :" -NoNewline
    $bogus = $false
    :nextline foreach ($char in $line.ToCharArray()) {
        Write-Host "$char" -NoNewline
        switch ($char) {
            ')' { 
                if ($stack.Peek() -eq '(') {
                    $null = $stack.Pop()
                }
                else {
                    $bogus = $true
                    break nextline
                } 
            }
            ']' {
                if ($stack.Peek() -eq '[') {
                    $null = $stack.Pop()
                }
                else {
                    $bogus = $true
                    break nextline
                } 
            }
            '}' { 
                if ($stack.Peek() -eq '{') {
                    $null = $stack.Pop()
                }
                else {
                    $bogus = $true
                    break nextline
                } 
            }
            '>' {  
                if ($stack.Peek() -eq '<') {
                    $null = $stack.Pop()
                }
                else {
                    $bogus = $true
                    break nextline
                } 
            }
            Default { $stack.Push($char) }
        }
    }
    if ($bogus -eq $false) {
        Write-Host "=> $stack ::: " -NoNewline
        $lineresult = 0
        while ($stack.Count -gt 0) {
            switch ($stack.Pop()) {
                '(' { Write-Host ')' -NoNewLine; $lineresult *= 5; $lineresult += 1 }
                '[' { Write-Host ']' -NoNewLine; $lineresult *= 5; $lineresult += 2 }
                '{' { Write-Host '}' -NoNewLine; $lineresult *= 5; $lineresult += 3 }
                '<' { Write-Host '>' -NoNewLine; $lineresult *= 5; $lineresult += 4 }
            }
        }
        Write-Host " == $lineresult" -NoNewline
        $results += $lineresult
    }

    
}
Write-Host "`n"

$results = $results | Sort-Object
Write-Host "$results"
$median = $results[([Math]::Ceiling($results.Count / 2) - 1)]
Write-Host "Median: $($median)"
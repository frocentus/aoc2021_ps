$data = Get-Content -Path "$($PSScriptRoot)/input.txt"

class Point {
    [int]$x
    [int]$y

    Point(
        [string]$x,
        [string]$y
    ){
        $this.x = [int]$x
        $this.y = [int]$y
    }

    [string]ToString(){
        return ("Point: {0},{1}" -f $this.x, $this.y)
    }

}

class Edge {
    [Point]$from
    [Point]$to

    Edge(
        [Point]$from,
        [Point]$to
    ) {
        $this.from = $from
        $this.to = $to
    }

    [string]ToString(){
        return ("Edge: {0} -> {1}" -f $this.from, $this.to)
    }

    [bool]IsHorizontal() {
        return $this.from.y -eq $this.to.y
    }   
    
    [bool]IsVertical() {
        return $this.from.x -eq $this.to.x
    }
    
    [Point[]] GetPoints() {
        $points = @()

        $x1 = $this.to.x
        $x2 = $this.from.x

        $y1 = $this.to.y
        $y2 = $this.from.y

        $dx = [Math]::Abs($x1 - $x2);
        $dy = [Math]::Abs($y1 - $y2);
        
        $sx = ($x1 -lt $x2) ? 1 : -1;
        $sy = ($y1 -lt $y2) ? 1 : -1;
        
        $err = $dx - $dy;
        
        while ($true) {
            $points += [Point]::new($x1, $y1)
       
            if ($x1 -eq $x2 -and $y1 -eq $y2) {
                break;
            }
        
            $e2 = 2 * $err;
        
            if ($e2 -gt -$dy) {
                $err = $err - $dy;
                $x1 = $x1 + $sx;
            }
        
            if ($e2 -lt $dx) {
                $err = $err + $dx;
                $y1 = $y1 + $sy;
            }
        }

        return [Point[]]$points
    }    
}

function ParseLine {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $line
    )

    $elements = $line.Split(' -> ')
    $coords1 = $elements[0].Split(',')
    $coords2 = $elements[1].Split(',')
    $point1 = [Point]::new($coords1[0], $coords1[1])
    $point2 = [Point]::new($coords2[0], $coords2[1])
    [Edge]::new($point1, $point2)

}

$allthepoints = @()

$data.ForEach({
 
    $edge = ParseLine($_)
    $allthepoints += $edge.GetPoints()

})

($allthepoints | Group-Object -Property x,y | Where-Object { $_.Count -gt 1} | Measure-Object).Count
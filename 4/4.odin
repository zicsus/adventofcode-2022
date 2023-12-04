package main;

import "core:fmt";
import "core:strings";
import "core:strconv";
import "core:time";
import "../utils";

contains :: proc(a: []string, b: []string) -> (bool, bool)
{
    a0, _ := strconv.parse_int(a[0]);
    a1, _ := strconv.parse_int(a[1]); 
    b0, _ := strconv.parse_int(b[0]);
    b1, _ := strconv.parse_int(b[1]); 

    full := (
        (b0 - a0 >= 0 && b1 - a1 <= 0) || 
        (a0 - b0 >= 0 && a1 - b1 <= 0)
    );
    partial := (
        (b0 >= a0 && b0 <= a1) ||
        (a0 >= b0 && a0 <= b1)
    );

    return full, partial;
}

main :: proc()
{
    stopwatch : time.Stopwatch;
    time.stopwatch_start(&stopwatch);
    
    lines := [dynamic]string{};
    ok := utils.read_file_by_lines("./4/input.txt", &lines);
    if !ok
    {
        fmt.println("Unable to read file!");
        return;
    }
    
    fully := 0
    overlaps := 0
    
    for line in lines
    {
        arr := strings.split(line, ",");
        a := strings.split(arr[0], "-");
        b := strings.split(arr[1], "-");
        
        full, partial := contains(a, b);
        if (full) { fully += 1; }
        if (partial) { overlaps += 1;}
    }

    time.stopwatch_stop(&stopwatch);
    
    fmt.println("Full overlaps:", fully);
    fmt.println("Partial overlaps:", overlaps);
    fmt.printf("Time: %vms", time.duration_milliseconds(stopwatch._accumulation));
}
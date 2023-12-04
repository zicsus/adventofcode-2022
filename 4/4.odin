package main;

import "core:fmt";
import "core:strings";
import "core:strconv";
import "../utils";

contains :: proc(a: []string, b: []string) -> (bool, bool)
{
    a0, ok0 := strconv.parse_int(a[0]);
    a1, ok1 := strconv.parse_int(a[1]); 
    b0, ok2 := strconv.parse_int(b[0]);
    b1, ok3 := strconv.parse_int(b[1]); 

    full := b0 - a0 >= 0 && b1 - a1 <= 0;
    partial := b0 >= a0 && b0 <= a1;

    return full, partial;
}

main :: proc()
{
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

        fulla, partiala := contains(a, b);
        fullb, partialb := contains(b, a);

        if (fulla || fullb)
        {
            fully += 1;
        }
        
        if (partiala || partialb)
        {
            overlaps += 1;
        }
    }

    fmt.println(fully, overlaps);
}
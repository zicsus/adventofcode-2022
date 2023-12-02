package main

import "core:fmt";
import "core:strings";
import "../utils";


score :: proc(a: int, b: int) -> int 
{
    return a + 1 + ((4 + a - b) % 3) * 3;
}

to_play :: proc(them : int, result : int) -> int 
{
    return (3 + them + (result - 1)) % 3;
}

main :: proc() 
{
    lines := [dynamic]string{};

    ok := utils.read_file_by_lines("./2/input.txt", &lines);

    if !ok 
    {
        fmt.println("Failed to read file");
        return;
    }

    points := 0;
    for line in lines
    {
        them := int(line[0] - 'A');
        me := int(line[2] - 'X');

        round := score(me, them);
        points += score(to_play(them, me), them);
    }

    fmt.println(points);

}

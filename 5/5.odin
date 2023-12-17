package main;

import "core:fmt";
import "core:strings";
import "core:strconv";
import "core:container/queue";
import "core:time";
import "../utils";

main :: proc()
{
    stopwatch : time.Stopwatch;
    time.stopwatch_start(&stopwatch);

    lines := [dynamic]string{};
    ok := utils.read_file_by_lines("./5/input.txt", &lines);
    if !ok
    {
        fmt.println("Unable to read file!");
        return;
    }

    stacks : [9]queue.Queue(u8);
    flag := false;

    for line in lines
    {   
        if (len(line) == 0) 
        {
            flag = true;
            continue;
        }

        if (!flag)
        {
            idx := 0;
            for offset := 1; offset < len(line); offset += 4 
            {
                chr := line[offset];
                if (chr == '1') do break;
                if (chr != ' ') do queue.push_back(&stacks[idx], chr);
                idx += 1;
            }
        }
        else 
        {
            arr := strings.split(line, " ");
            num, _ := strconv.parse_uint(arr[1]);
            from, _ := strconv.parse_uint(arr[3]);
            dst, _ := strconv.parse_uint(arr[5]);
            
            for _ in 0..<num
            {   
                queue.push_front(&stacks[dst-1], queue.pop_front(&stacks[from-1]));
            }
        }
    }

    first := [dynamic]u8{};
    for _, idx in stacks
    {
        append(&first, queue.front(&stacks[idx]));
    }

    time.stopwatch_stop(&stopwatch);

    fmt.println("First:", string(first[:]));

    fmt.printf("Time: %vms", time.duration_milliseconds(stopwatch._accumulation));
}
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

    stack1, stack2 : [9]queue.Queue(u8);
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
                if (chr != ' ') 
                {
                    queue.push_back(&stack1[idx], chr);
                    queue.push_back(&stack2[idx], chr);
                }
                idx += 1;
            }
        }
        else 
        {
            arr := strings.split(line, " ");
            num, _ := strconv.parse_uint(arr[1]);
            from, _ := strconv.parse_uint(arr[3]);
            dst, _ := strconv.parse_uint(arr[5]);
            
            temp_arr := [dynamic]u8{};
            for _ in 0..<num
            {
                queue.push_front(&stack1[dst-1], queue.pop_front(&stack1[from-1]));
                append(&temp_arr, queue.pop_front(&stack2[from-1]));
            }

            for i := len(temp_arr) - 1; i >= 0; i -= 1
            {
                queue.push_front(&stack2[dst-1], temp_arr[i]);
            }
        }
    }

    first, second := [dynamic]u8{}, [dynamic]u8{};
    for _, idx in stack1
    {
        append(&first, queue.front(&stack1[idx]));
    }

    for _, idx in stack2
    {
        append(&second, queue.front(&stack2[idx]))
    }

    time.stopwatch_stop(&stopwatch);

    fmt.println("First:", string(first[:]));
    fmt.println("Second:", string(second[:]));

    fmt.printf("Time: %vms\n", time.duration_milliseconds(stopwatch._accumulation));
}
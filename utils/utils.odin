package utils;

import "core:fmt";
import "core:os";
import "core:strings";

read_file_by_lines :: proc(filepath: string, lines: ^[dynamic]string) ->  bool
{
    data, ok := os.read_entire_file(filepath, context.allocator);

    if !ok 
    {
        fmt.println("Failed to read file");
        return ok;
    }

    it := string(data);
    for line in strings.split_lines_iterator(&it)
    {
        append(lines, line);
    }
    
    return true;
}

binary_search :: proc(items: []$E, to_find: int) -> bool
{
    result := false;
    
    low := 0;
    high := len(items) - 1;

    for low <= high
    {
        mid := low + (high - low) / 2; 
        
        if (to_find < items[mid])
        {
            high = mid - 1;
        }
        else if (to_find > items[mid])
        {
            low = mid + 1;
        }
        else
        {
            result = true;
            break;
        }
    }

    return result;
} 
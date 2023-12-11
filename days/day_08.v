module days

import math

const lr_directions = {
	`L`: 0
	`R`: 1
}

pub fn day_eight(input string) !(string, string) {
	parts := input.split('\n\n')

	instructions := parts[0].runes().map(days.lr_directions[it])
	node_list := parts[1].split_into_lines()
		.map(it.split_any(' =(,)').map(it.trim_space()).filter(it != ''))

	mut nodes := map[string][]string{}
	for node in node_list {
		nodes[node[0]] = node[1..]
	}

	mut part_one := i64(0)
	if 'AAA' in nodes {
		part_one = find_path_length('AAA', nodes, instructions)
	}

	mut part_two := part_one
	mut starts := node_list.filter(it[0][2] == `A` && it[0] != 'AAA').map(it[0])
	for start in starts {
		path_len := find_path_length(start, nodes, instructions)

		if part_two == 0 {
			part_two = path_len
		} else {
			part_two = math.lcm(part_two, i64(path_len))
		}
	}

	return part_one.str(), part_two.str()
}

fn find_path_length(start string, nodes map[string][]string, instructions []int) int {
	mut current := start
	mut path_length := 0
	outer: for {
		for instruction in instructions {
			current = nodes[current][instruction]
			path_length += 1

			if current[2] == `Z` {
				break outer
			}
		}
	}

	return path_length
}

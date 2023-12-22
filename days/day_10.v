module days

import arrays

pub fn day_ten(input string) !(string, string) {
	lines := input.split_into_lines()
	width := lines[0].len + 2

	extra_row := '.'.repeat(width)

	mut padded := [extra_row]
	padded << lines.map('.${it}.')
	padded << extra_row

	mut grid := arrays.flatten(padded.map(it.runes()))
	start := grid.index(`S`)

	mut curr := get_next(grid, width, start, start - width - 1)
	mut prev := start
	mut path := [curr]
	for curr != start {
		next_prev := curr
		curr = get_next(grid, width, curr, prev)
		path << curr
		prev = next_prev
	}

	part_one := path.len / 2

	grid[start] = match [
		grid[start - 1] in [`-`, `L`, `F`],
		grid[start + 1] in [`-`, `J`, `7`],
		grid[start - width] in [`|`, `7`, `F`],
		grid[start + width] in [`|`, `J`, `L`],
	] {
		[true, true, false, false] { `-` }
		[false, false, true, true] { `|` }
		[true, false, true, false] { `J` }
		[false, true, true, false] { `L` }
		[false, true, false, true] { `F` }
		else { grid[start] }
	}

	mut part_two := 0
	for i, _ in grid {
		x := i % width
		y := i / width
		if x == 0 || x == width - 1 || y == 0 || y == lines.len + 1 || i in path {
			continue
		}

		if is_inside_polygon(grid, path, width, i, y) {
			part_two += 1
		}
	}

	return part_one.str(), part_two.str()
}

fn get_next(grid []rune, width int, curr int, prev int) int {
	if curr - 1 != prev && grid[curr] in [`S`, `-`, `J`, `7`]
		&& grid[curr - 1] in [`S`, `-`, `L`, `F`] {
		return curr - 1
	} else if curr + 1 != prev && grid[curr] in [`S`, `-`, `F`, `L`]
		&& grid[curr + 1] in [`S`, `-`, `J`, `7`] {
		return curr + 1
	} else if curr - width != prev && grid[curr] in [`S`, `|`, `J`, `L`]
		&& grid[curr - width] in [`S`, `|`, `7`, `F`] {
		return curr - width
	} else if curr + width != prev && grid[curr] in [`S`, `|`, `F`, `7`]
		&& grid[curr + width] in [`S`, `|`, `L`, `J`] {
		return curr + width
	}

	panic('No valid neighbours found')
}

fn is_inside_polygon(grid []rune, path []int, width int, point int, y int) bool {
	row := arrays.map_indexed(grid[y * width..point], fn [width, y] (i int, _ rune) int {
		return y * width + i
	})

	mut intersections := 0
	for i := 0; i < row.len; i += 1 {
		idx := row[i]
		if idx in path {
			chr := grid[idx]
			if chr == `|` {
				intersections += 1
			} else if chr == `F` {
				intersections, i = skip_along_line(grid, row, intersections, i, point,
					`7`)
			} else if chr == `L` {
				intersections, i = skip_along_line(grid, row, intersections, i, point,
					`J`)
			}
		}
	}

	return intersections > 0 && intersections % 2 != 0
}

fn skip_along_line(grid []rune, row []int, intersections int, i int, point int, end rune) (int, int) {
	mut new_intersections := intersections + 1
	mut new_i := i + 1

	if row[new_i] == point {
		return new_intersections, new_i
	}

	mut chr := grid[row[new_i]]
	for chr == `-` {
		new_i += 1
		if row[new_i] == point {
			break
		}
		chr = grid[row[new_i]]
	}

	if chr == end {
		new_intersections += 1
	}

	return new_intersections, new_i
}

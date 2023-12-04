module main

import os
import time
import days

fn main() {
	all_days := [
		days.day_one,
		days.day_two,
		days.day_three,
		days.day_four,
	]

	now := time.utc()
	mut day := 0
	if os.args.len == 1 {
		println('No day given, trying latest')
		max := time.parse('2023-12-25 05:00:00') or {
			println(err)
			return
		}
		if max < now {
			day = 25
		} else {
			day = now.day
		}
	} else {
		day = os.args[1].int()
	}

	then := time.parse('2023-12-${day} 05:00:00') or {
		println(err)
		return
	}

	if now < then {
		println('Day ${day} can\'t be started yet, ${then - now} left')
		return
	}

	input := match os.args.len {
		3 {
			os.read_file(os.args[2])!
		}
		else {
			get_input(day) or {
				println(err)
				return
			}
		}
	}

	if day > all_days.len {
		println('No code has been written for day ${day} yet')
		return
	}

	fun := all_days[day - 1]
	part_one, part_two := fun(input) or {
		println(err)
		return
	}

	println('[Day ${day}]')
	println('Part one: ${part_one}')
	println('Part two: ${part_two}')
}

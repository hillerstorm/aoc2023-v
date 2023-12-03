module days

fn test_day_one() {
	run_tests(day_one, [
		TestFixture{read_input(day: 1), '142', '142'},
		TestFixture{read_input(day: 1, version: 2), '209', '281'},
	])
}

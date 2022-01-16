#!/usr/bin/env bash

# file: backup_test.sh
# Doc: https://github.com/kward/shunit2

# Run before all tests
function oneTimeSetUp() {
    script=./backup_v3.sh
    dirs=./dir.csv
}

# Run before each test
function setUp() {
    return 0
}

function testOptionHelp() {
    assertContains "$($script -h)" help
}

function testOptionVersion() {
    assertContains "$($script -v)" "Version 1.0"
}

function testOptionsDryRun() {
    assertContains "$($script -d $dirs)" "(DRY RUN)"
}


# Run after each test
function tearDown() {
    return 0
}

source shunit2

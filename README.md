# Reverse Polish Notation Calculator

## Challenge
```
The goal of this exercise is to implement a command-line calculator which uses reverse polish
notation (RPN).
Reverse Polish notation (RPN) is a mathematical notation in which every operator
follows all of its operands, in contrast to Polish notation (PN), which puts the operator
before its operands. It is also known as postfix notation. It does not need any
parentheses as long as each operator has a fixed number of operands.
```

## To run:
* ruby index.rb

## Technologies
* Ruby

## References Used
* Syntax about testing capturing stdin / stdout: referred to a copy of the exceedingly simple and unfinished 'card game of war' program I wrote more than a year and a half ago as a learning exercise.
* Resolve unexpected error when using 'pry' gem: http://stackoverflow.com/questions/26860140/pry-nav-work-unexpectedly
* Difference between $stdout and STDOUT in Ruby: http://stackoverflow.com/questions/21343523/does-ruby-use-stdout-for-writing-the-output-of-puts-and-return
* Git syntax foo for squashing into the first commit:
http://stackoverflow.com/questions/598672/squash-the-first-two-commits-in-git
* Mock user input (object receives :gets not $stdin)
http://stackoverflow.com/questions/37753893/how-to-stub-mock-multiple-options-depending-on-user-input-with-rspec-3-4
* Rspec Mocks
http://stackoverflow.com/questions/21262309/rspec-how-to-test-if-a-method-was-called
http://www.rubydoc.info/github/rspec/rspec-mocks/RSpec/Mocks/ExampleMethods
* Find a way to load a file multiple times in one spec file in order to maintain segregation between tests
http://stackoverflow.com/questions/2635108/running-another-ruby-script-from-a-ruby-script
http://ruby-doc.org/core-2.0.0/Kernel.html#method-i-load
* Tricks for testing methods with until loops
https://www.relishapp.com/rspec/rspec-mocks/v/2-13/docs/message-expectations/receive-counts
https://groups.google.com/forum/#!topic/rspec/oswjBjQ1WPw
* Private constants
https://aaronlasseigne.com/2016/10/26/know-ruby-private_constant/
* Efficient way to generate basic extended list of character input for testing (reference includes benchmarks on various approaches)
http://caseyscarborough.com/blog/2013/07/23/generating-alphanumeric-strings-in-ruby/
* That CTRL-D sends 'end-of-file' not a Signal and syntax for testing it
http://stackoverflow.com/questions/1516122/how-to-capture-controld-signal
http://stackoverflow.com/questions/21648637/ruby-scan-gets-until-eof
* Clean equivalent to "drop" for end of an array (sadly, there isn't one)
http://stackoverflow.com/questions/1604305/all-but-last-element-of-ruby-array
* Ruby array syntax for writing recursive Calculation.compute method
https://ruby-doc.org/core-2.2.0/Array.html
http://stackoverflow.com/questions/2381163/ruby-array-find-first-object

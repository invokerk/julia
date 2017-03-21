# This file is a part of Julia. License is MIT: http://julialang.org/license

let filename = tempname()
    # Make sure that failed downloads do not leave files around
    @test_throws ErrorException download("http://httpbin.org/status/404", filename)
    @test !isfile(filename)

    @test Base.downloadcmd == :curl

    # Use a TEST-NET (192.0.2.0/24) address which shouldn't be bound
    @test_throws ErrorException download("http://192.0.2.1", filename)
    @test !isfile(filename)

    # Download an empty file
    @test download("http://httpbin.org/status/200", filename) == filename
    @test isfile(filename)
    @test isempty(read(filename))
    rm(filename)
end

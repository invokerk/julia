# This file is a part of Julia. License is MIT: http://julialang.org/license

@testset "download" begin

let file = tempname()
    @test download("http://httpbin.org/status/200", file) == file
    @test isfile(file)
    @test isempty(read(file))
    rm(file)

    # Make sure that failed downloads do not leave files around
    @test_throws ErrorException download("http://httpbin.org/status/404", file)
    @test !isfile(file)

    # Use a TEST-NET (192.0.2.0/24) address which shouldn't be bound
    @test_throws ErrorException download("http://192.0.2.1", file)
    @test !isfile(file)
end

end

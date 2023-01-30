class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.13.3"
    checksums = {
        "darwin_arm64" => "d9cf756b6d261f2305843a86ccd1c64d154d8cdc9db39b0e0c09ae7bbf6ce05c",
        "darwin_amd64" => "fe8c8fac7218344adace1b8c85d136c2c698ff3608b5fd610f987f27a3ea0146",
        "linux_arm64"  => "5cad231de8f083df53d5012778dc9c060bf3d3c9ee96a56983ad2d1e5287bba4",
        "linux_amd64"  => "4e1e543595cd731409759ee481acf9783991f7edff7246f8e39526488c1bd56d",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end

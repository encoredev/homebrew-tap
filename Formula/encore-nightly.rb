class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230823"
    checksums = {
        "darwin_arm64" => "431a8739d5337a9a3ac51b177a032a8e0847015eb1ae1ae6351805d07b07a64d",
        "darwin_amd64" => "05305e2cb8e43ff1f822bf2277056f49c5128d9f11c4b6386d0dfa98aa6247db",
        "linux_arm64"  => "aa6128d27d7b9bb9d6fcd7fe26eec357f02cc2360dda197c5dbee87b2c69cfba",
        "linux_amd64"  => "ffe6a1c888512a562ecbfb4c39ef1ba59e7decaa02cba206fe4cfb1e7f9c98a1",
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

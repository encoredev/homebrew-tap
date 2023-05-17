class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.19.0"
    checksums = {
        "darwin_arm64" => "f3f098592c70bba651fe714451aaf9add8e254f88c19762d67eba03b83f1e46a",
        "darwin_amd64" => "4a70a5d6ec2729bc9567993ae2ea7b37f26ff1ef67896ff9b543dab7d044c125",
        "linux_arm64"  => "a41d3b67bf3d6523e87a4b487c4f4eeff245282b7e5aa300bce23d189286893b",
        "linux_amd64"  => "3d7399a5dbeff8d8cf1c5a72a264d1c109be921ce7bb220ba1864e623351e8cf",
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

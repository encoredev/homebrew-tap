class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.31.2-beta.2"
    checksums = {
        "darwin_arm64" => "4bef4e24c0a1103b8254701691a07b2a138988df52d30c6e1a6bdfddd1d1e13a",
        "darwin_amd64" => "f85cf9397529df3056193da73636585300a1a0cd4c4ff8e11a7a0070fcda18ed",
        "linux_arm64"  => "2f5dae65277b69fbe8f5746926aa223f89be94df4f214eb07682ceb2d7e96755",
        "linux_amd64"  => "79b48118e75d8a62b9922cf6d69f6a941bdcebcbb5c42e1372d09f2a1716d879",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end

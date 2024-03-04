class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.31.2-beta.6"
    checksums = {
        "darwin_arm64" => "486cf793c31b59c4f53a1b68c38e9b2d410f1375a728fb6d90b38818512c1e57",
        "darwin_amd64" => "d642e12044d6f8da98c2b5b6b309c54cf6a374c0c3538d60779db15e086594df",
        "linux_arm64"  => "6c1ca73c7386b7f334d38df03ab510471ffc2bf6cfde54c499bf3dbfdaeb0758",
        "linux_amd64"  => "1c56d00e9c30fa42aa15653b29416ce85c85526293793d51a4c35eca27894360",
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

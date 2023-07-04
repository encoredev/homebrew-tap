class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230704"
    checksums = {
        "darwin_arm64" => "fe41f08d05f9f6327de2f51cfd38e31fbc5b1ef1b755b76c47d7bf2af1c1f7e2",
        "darwin_amd64" => "de2e123cb1297780f8f0a41f09b670a389bc58972bfb6e9b891aad641370dcea",
        "linux_arm64"  => "fcfde746cb1aa8dc4bcbf822acb51037ca742cd4ff85a11ed197854cc70ece8d",
        "linux_amd64"  => "b7b3bc13ab2faf292497f183f0ac9f6410b531daec02a644bfb01ec8b913735d",
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

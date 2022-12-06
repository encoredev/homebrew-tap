class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221206"
    checksums = {
        "darwin_arm64" => "3fb0edf62a818c9de346759092721279706e783dce92326d115363a610e1314c",
        "darwin_amd64" => "50085952bab8d05e34e3a5175f485fe4abff137a46a3a4588a72b7b9933d88bd",
        "linux_arm64"  => "eefe4a440e8eb49ae7efaad32ceb15fd422388c061965d0cbdf0d5d1e5de52eb",
        "linux_amd64"  => "67ded15a09fbaf4e71075dc402922db04e493c9c32edb3fafeb62472339955e9",
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

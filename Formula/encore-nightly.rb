class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230428"
    checksums = {
        "darwin_arm64" => "08ffa9a28de55669c88d849b0810b006ce4287445a53356fd94a1471fdc5baf2",
        "darwin_amd64" => "a78d699d8b9e21604ade53da2a211ab1608f6f32971010e7c701d61e0bde4074",
        "linux_arm64"  => "5e8957614af42db4818b75838d9b36bb079eb2d3c9a462f7e9bf91901a8e4f51",
        "linux_amd64"  => "5781dc6a2e4eb68e3b06f3f236ad597a607c75f89e202f1b6485af66ab68b856",
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

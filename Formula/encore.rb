class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.36.1"
    checksums = {
        "darwin_arm64" => "9949bc21413dc38c3e12a16497c97860bc87ffc756da7b226c69a206d804841e",
        "darwin_amd64" => "dc446a08394e2e3d03ffbf20e17b5440a0b1e7d301b213a90c672cc7efecf193",
        "linux_arm64"  => "177e210b7a06beed37735ca1fa569d73c5a5b4fed77fa37290a8cbb85ea1d814",
        "linux_amd64"  => "b64427b494b4f671f2beb476618b0f40b6363ba34524121ccd807b9e27bea030",
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

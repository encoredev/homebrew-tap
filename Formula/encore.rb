class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.11.1"
    checksums = {
        "darwin_arm64" => "b4cae7e37df8f78f2094cbbb45ec80b449cd8415cf6f713a74ef73a0cd3b5227",
        "darwin_amd64" => "98257b46f1ee72b7a443438b832f570ea0d7b377063ae2a567805833eeda41d8",
        "linux_arm64"  => "0204fd32c55a2a849078c39b12806ffafffb03f65393f9522a1d55e534fcb563",
        "linux_amd64"  => "85ca2925e9bc51767ba2acfdeafab5fe312b96442ecc29d267b389fc1f0be4a5",
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

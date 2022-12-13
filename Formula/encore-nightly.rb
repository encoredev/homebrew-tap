class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221213"
    checksums = {
        "darwin_arm64" => "a082cc7e49d85d70c826056d280cb79215abdcd1d19a9edebe88527be84eaabf",
        "darwin_amd64" => "bd824a4c131dbf353a7af261d6237e132a62655b2106932c9ff2df0223d8a70f",
        "linux_arm64"  => "67bd1cc5b21f3b6f4222898bfde7a5efcea3fee0f6ed9da6602bd00c64cd2b50",
        "linux_amd64"  => "da7510780e9c132ff8cb440f67fcbe8973d7be70fa4d633e7379a5be6055cf7d",
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

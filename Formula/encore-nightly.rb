class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231024"
    checksums = {
        "darwin_arm64" => "405e1b30717b0d345890cdd5e3f4a3ee430f1d06e5e1b1b47bea101499c2cb08",
        "darwin_amd64" => "c6c85c5381a7d2e738a414d38b5a25862a791dc81311957c7199a5fed66297be",
        "linux_arm64"  => "7c460bab758fe51caeaf9d12716e6b2731911e8a53e738663485990fb42a4131",
        "linux_amd64"  => "78fec700319c7372e15da27987829a02712055f6be32d296abcdd49b9b3dbbf9",
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

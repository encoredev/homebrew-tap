class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.14.3"
    checksums = {
        "darwin_arm64" => "4cd928f8721101bc64c5ff996e8b09bb61843661bc2384af5288ee0e7878ed96",
        "darwin_amd64" => "6c52ec451d643dbd1d9b5f75b8875a65583b15fb1fa923f8d116ff1d8282e6c8",
        "linux_arm64"  => "27471b30abacc67b2b7be7a6fce87fc5d8bbb93e1047de3cbb0e8442fb28cfb8",
        "linux_amd64"  => "5cc5341aa40421f5c58eda18eca25f630b1605653e641616b06a99496442f6e1",
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

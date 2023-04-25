class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230425"
    checksums = {
        "darwin_arm64" => "5840d4124e6cebbb64902d60b483c8d7b36fb6dc8869562a019bff67b31769d0",
        "darwin_amd64" => "adacbc1d3257ca038df8bb87c1f78749b6e9f159d576b2b34a77963aaf2145c5",
        "linux_arm64"  => "cd621e785a04760314708f3ede3ee80162f60384deb4d4a12df673eca58024a1",
        "linux_amd64"  => "768d0ccbf9bd5145069346eeea546116406ef971dfc16ebb6c38f218416fe284",
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

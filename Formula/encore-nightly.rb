class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230914"
    checksums = {
        "darwin_arm64" => "1007c6a9bfebc80e5150f039349d26c623fa06e5428dbd87dc1873829fd026b0",
        "darwin_amd64" => "09d477851e92f955c48e228120e7ec0be78482b45b34d4ff613156d04c527480",
        "linux_arm64"  => "05dd9a4fd89aa2ea8951602d8afb0280884ddbb3ea480725cb1911a4416cfeb6",
        "linux_amd64"  => "1acdebe9e454d6e6990462630e48666a640453600b2157561a6a12ac03974a86",
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

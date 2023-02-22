class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230222"
    checksums = {
        "darwin_arm64" => "9f05e32fccc927a940ed72bfe5994f61d9f01403a78cdb11d59c4e55830b261c",
        "darwin_amd64" => "aba934907ea4db1e25ec0b0230ddfa8ee574bca25ca29222ba38e64e35a2c3e4",
        "linux_arm64"  => "025294782923a3c397aa96c707a6bcacf04294ae265ea5f04f5a62fdda127fea",
        "linux_amd64"  => "09a85f5da77fa264fd17cb9d6699618cd932f8b505c07210047946f5d6d8c844",
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

class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230121"
    checksums = {
        "darwin_arm64" => "65e0dfe80b88fce9d88f13c5de0b47ab7998930df4705bc74e9ae4a5c87d21f1",
        "darwin_amd64" => "14009e073a9ea706fa049defea6fb5e3af32216fbddc19354a87b741787a813b",
        "linux_arm64"  => "e1e6ca4ff70a7eeabc075c2b94581eca914ff1d1690a9e5cb7c447101c112570",
        "linux_amd64"  => "c8bcf37c58cace5f9e5d8f8925912a134705c0925214c08b8ed03827efbfeb72",
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

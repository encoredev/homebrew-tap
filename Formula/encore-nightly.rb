class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230127"
    checksums = {
        "darwin_arm64" => "86f63d4b8ac2566c4d3f2f65f2aa0f9d552d9214930d5f540e0c0231129ab442",
        "darwin_amd64" => "e2ed487a703120592ac216599fafbac16cee27e81f6a699254a734491a6e4677",
        "linux_arm64"  => "6af4be546fefd3b4121209cb284af187d88740229b65203b227a28965b40f074",
        "linux_amd64"  => "74f256100261471e6021bb7a2343d061892b5ff1a7d2279a4cfbdc2f3c9c7fef",
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

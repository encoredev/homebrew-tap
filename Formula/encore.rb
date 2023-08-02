class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.23.0"
    checksums = {
        "darwin_arm64" => "48debda2894fddbfec4ce9ed54e3dac3d5db3deee2839bc10a12adc7ae34b453",
        "darwin_amd64" => "fe0b19296cebcbe72f3be22c004984656eb040a50f3e14a511242ed955d25e18",
        "linux_arm64"  => "3b04fe2803e6bb56ae3860c3200873d454ecd6019b2c6a9ff0987d88fe46948b",
        "linux_amd64"  => "b226c2e0d519c4c514a4028b4a98b05e5d204d0ebad4d3bd4e87c9e3f3f91d6f",
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

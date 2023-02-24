class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230224"
    checksums = {
        "darwin_arm64" => "dc1f5ca72111aa30035d44176b5f999c50b7aeee3ad031a2ecbbc93c9ebddaf7",
        "darwin_amd64" => "6f26673f4e4c245923b3bc6792ede006d0d05cf6ab7d70d57a733942f5975829",
        "linux_arm64"  => "d2bd8d459768ae1cd5bda430a8ad7149dab6e9d07025b395d4f8f672fb8003de",
        "linux_amd64"  => "59e0d9879415602f879ca8bd4aabac259694eb4f9a5294647ef040a493e71bb6",
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

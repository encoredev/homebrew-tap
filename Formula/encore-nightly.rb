class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230602"
    checksums = {
        "darwin_arm64" => "a029bb1cad20ac260619ecbf163bf469f77bb8dda0e26c0d8b17d128f4699a2e",
        "darwin_amd64" => "47aded446a46afd14a41ed0f0e151b18a88508976a01b08c866c53e8fc48f73f",
        "linux_arm64"  => "d7c5a8eb7f8b530af1636fa222b1eb8413523ff41bfbbb519b462c7f743aee31",
        "linux_amd64"  => "72dc120dd783f478c7adc5157a6a75fe0ed8e67908402018d421f8461a85a1ae",
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

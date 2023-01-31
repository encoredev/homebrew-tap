class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230131"
    checksums = {
        "darwin_arm64" => "0cbac2a21a7b629e4460b2b947c5826a052311631ed9152bb90e61e58099785e",
        "darwin_amd64" => "af65996f0e21666d42aada47292ff99e92d7d3b0de743bff2a3224708d3a689d",
        "linux_arm64"  => "bb936e4d4d582e9849d7aa64422f36ef6149036ede6e9d26d9051fb1bd2940ef",
        "linux_amd64"  => "a207b70ffa302aedfe7c853d69eca6da1e95f2936c84111332aedba1e1a27fb6",
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

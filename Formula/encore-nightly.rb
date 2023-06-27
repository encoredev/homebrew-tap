class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230627"
    checksums = {
        "darwin_arm64" => "a0b05f1f6053947a652b21f158cd1cddf97da427a0d98fce27e631679fd6b068",
        "darwin_amd64" => "15c877aa8206cdbaf2a84b5aeda8953728ec9af9bf53b4b300cab1b7729b29fe",
        "linux_arm64"  => "fc1cfa6ba2eb7003bf432ba02449694c2ac80a6d30b25e1af198fa1b0f667d3e",
        "linux_amd64"  => "72b1e594e320132ac406c147c51033c73b178630ad085a6d4c802761f01ff507",
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

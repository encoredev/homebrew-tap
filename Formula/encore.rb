class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.13.1"
    checksums = {
        "darwin_arm64" => "9e80d274dd77ee9344caaeff9012b678f338a2b0ba90fb9b9ea1ae034237f1e4",
        "darwin_amd64" => "ef21d765fbff4d5b4958d81ae7bca381f5fde4492a58c347ea05119f8c74b694",
        "linux_arm64"  => "c70c8c1662d064d53a70d1452d1edf39a3e1e191c683a89b6b336dfde4035bbd",
        "linux_amd64"  => "21e16ed35714a4ef603f258be8d3bfcbb2ff6488a6d07742cfe7cf6884b9d138",
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

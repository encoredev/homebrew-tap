class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221202"
    checksums = {
        "darwin_arm64" => "8f8912ba7bd6bcb532456c1ccd56be21f5cd468a89628351980ad938f7f5f2d2",
        "darwin_amd64" => "7d606aa6e4671d7011ead0fbbd5a757bd98a7b9026db19e4c858f468acc29d76",
        "linux_arm64"  => "ef64a18954d40c407192b4882d7a50242759629593b93ac1de8eee9676ad340d",
        "linux_amd64"  => "2eb325e9b51d3be4e19ef681eb3c0f2c983cc04ce1216cd143eda7205ee6434c",
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

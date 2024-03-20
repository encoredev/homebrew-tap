class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.1"
    checksums = {
        "darwin_arm64" => "b2cb9eb844911b4589f12a9e2915ceaaf3a1277f2627badd493b8b5cbe07e95f",
        "darwin_amd64" => "93c8c88b5d2f34912e38bd4d81720bd9de248fe48be496a4fefd693acb658339",
        "linux_arm64"  => "75e33d395f684dcf7a6a2dfc02a2ccc0ea2a787a24a54fc5fd77a78e8a4a0cfd",
        "linux_amd64"  => "45bcd1d4764cd4725f8d4a6d07ced9e9814c3729b22915c6640989ac344e3a30",
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

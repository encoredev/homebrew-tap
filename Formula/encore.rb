class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.40.3"
    checksums = {
        "darwin_arm64" => "6191f14020de03c58e236a27c50ed04be5d6aa90a02bdeb9a9bc3bcd0a704bd1",
        "darwin_amd64" => "c83685a5cb6b8cc1e6966d54349ee4af20070a76236ae70d022d723f2405db56",
        "linux_arm64"  => "3cd47edc6f02f4288285138a77f9fd7d8707834bc7128635dc35f52938309959",
        "linux_amd64"  => "23589c9b37cb967a96871bb0e29b8ace16df113dd65d3190c9cba9ebe66002a4",
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

class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230323"
    checksums = {
        "darwin_arm64" => "fce95defceeedc8889ed26bc111ec765509988aeeb17ef1bb2f787750bc76e4e",
        "darwin_amd64" => "5d755ba74d8f4c1f8b3c6fa292c47dcdf5fa7dba1c7c61157c4af0044b69d356",
        "linux_arm64"  => "b46acfc46d254c7bbc5245568419072153ea2828e31695d484c2ea57ba4e68e2",
        "linux_amd64"  => "3f88e71ce70c6b21f8401c4476846d580b877a398cdc18182a6b47f7617ad323",
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

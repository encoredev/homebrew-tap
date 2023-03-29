class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230329"
    checksums = {
        "darwin_arm64" => "dd81f2763e6f8299b30fef78899adba72d48d94b5e7bacb278ae2b8b52b88590",
        "darwin_amd64" => "92c4b284f5966e178a55a09a0359de2f7e787ea7845bdae907c637101ee02fb8",
        "linux_arm64"  => "06d3d5ef63ccaa93671e33e548a68f84d53504346940d4ee113348df014e56ad",
        "linux_amd64"  => "344bd718afc6e30a39f25ae1676c99f05dec07a0bd675776642508c983f8550a",
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

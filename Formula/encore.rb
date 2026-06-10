class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.57.8"
    checksums = {
        "darwin_arm64" => "055619090b6a57319ffd3b06c052547e40dee01af6f4cba62084d916984b0338",
        "darwin_amd64" => "15569df94ac1e60996eee764f900579d535eebfc398c44ef184343858bbf3ec4",
        "linux_arm64"  => "ae41ea792e77ee2eba961075a2858f6228bb25a594e08d49ea122ceac187bcc1",
        "linux_amd64"  => "59ac867590cb5572410b8b911c28f8263aeb0df5a9eccd2042a6a64a26597d4e",
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
